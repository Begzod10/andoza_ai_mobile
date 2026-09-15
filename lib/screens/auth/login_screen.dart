import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/design_tokens.dart';
import '../../providers/auth_provider.dart';
import '../../repositories/auth_repository.dart';

/// Login screen — a Flutter port of the web `/login` page: phone-OTP by default,
/// with a 6-digit code step, plus username/password login and registration.
/// On success it flips [authStateProvider] to authenticated and the router's
/// redirect navigates onward.
enum _Mode { otpPhone, otpCode, login, register }

const int _resendCooldown = 60;

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  _Mode _mode = _Mode.otpPhone;

  final _phone = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _name = TextEditingController();

  final List<TextEditingController> _otp =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocus = List.generate(6, (_) => FocusNode());

  bool _loading = false;
  String? _error;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  /// The resend cooldown ticks once a second. Kept in a [ValueNotifier] (not
  /// plain state) so the timer only rebuilds the small countdown label via a
  /// [ValueListenableBuilder] instead of setState-ing the entire screen.
  final ValueNotifier<int> _cooldown = ValueNotifier<int>(0);
  Timer? _timer;
  String _sentPhone = '';

  @override
  void dispose() {
    _timer?.cancel();
    _cooldown.dispose();
    for (final c in [_phone, _username, _password, _confirm, _name, ..._otp]) {
      c.dispose();
    }
    for (final f in _otpFocus) {
      f.dispose();
    }
    super.dispose();
  }

  // ── helpers ───────────────────────────────────────────────────────────────
  String _formatPhone(String raw) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('998')) return '+$digits';
    if (digits.startsWith('0')) return '+998${digits.substring(1)}';
    return '+998$digits';
  }

  bool _isValidPhone(String phone) => RegExp(r'^\+998\d{9}$').hasMatch(phone);

  void _switch(_Mode m) => setState(() {
        _mode = m;
        _error = null;
      });

  void _startCooldown() {
    _timer?.cancel();
    _cooldown.value = _resendCooldown;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_cooldown.value <= 1) {
        t.cancel();
        _cooldown.value = 0;
      } else {
        _cooldown.value--;
      }
    });
  }

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  // ── actions ───────────────────────────────────────────────────────────────
  Future<void> _requestOtp() async {
    final phone = _formatPhone(_phone.text);
    if (!_isValidPhone(phone)) {
      setState(() => _error = "Telefon raqam noto'g'ri. Masalan: 90 123 45 67");
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await _repo.requestOtp(phone);
      _sentPhone = phone;
      _startCooldown();
      setState(() => _mode = _Mode.otpCode);
      WidgetsBinding.instance.addPostFrameCallback((_) => _otpFocus[0].requestFocus());
    } catch (_) {
      setState(() => _error = "Serverda xatolik. Qayta urinib ko'ring.");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _verifyOtp(String code) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await _repo.verifyOtp(_sentPhone, code);
      ref.read(authStateProvider.notifier).setSession(res);
    } catch (_) {
      setState(() {
        _error = "Kod noto'g'ri yoki eskirgan.";
        for (final c in _otp) {
          c.clear();
        }
      });
      _otpFocus[0].requestFocus();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _resend() async {
    if (_cooldown.value > 0) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await _repo.requestOtp(_sentPhone);
      for (final c in _otp) {
        c.clear();
      }
      _startCooldown();
      _otpFocus[0].requestFocus();
    } catch (_) {
      setState(() => _error = "Serverda xatolik. Qayta urinib ko'ring.");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _login() async {
    if (_username.text.trim().isEmpty || _password.text.isEmpty) {
      setState(() => _error = 'Username va parol majburiy.');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    // Drive the login through AuthNotifier so AuthState is the single source of
    // truth: on success it flips to AuthAuthenticated (the router redirect
    // navigates onward); on failure it lands in AuthError, which we surface with
    // the same inline message as before.
    await ref.read(authStateProvider.notifier).login(
          _username.text.trim(),
          _password.text,
        );
    if (!mounted) return;
    final state = ref.read(authStateProvider);
    setState(() {
      _loading = false;
      if (state is AuthError) _error = "Username yoki parol noto'g'ri.";
    });
  }

  Future<void> _register() async {
    final u = _username.text.trim();
    if (u.length < 3) {
      setState(() => _error = 'Username kamida 3 ta belgidan iborat bo\'lishi kerak.');
      return;
    }
    if (_password.text.length < 6) {
      setState(() => _error = 'Parol kamida 6 ta belgidan iborat bo\'lishi kerak.');
      return;
    }
    if (_password.text != _confirm.text) {
      setState(() => _error = 'Parollar mos kelmadi.');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await _repo.register(u, _password.text, _name.text.trim());
      ref.read(authStateProvider.notifier).setSession(res);
    } catch (e) {
      final msg = e.toString().toLowerCase();
      setState(() => _error = (msg.contains('409') || msg.contains('band'))
          ? 'Bu username allaqachon band.'
          : "Ro'yxatdan o'tishda xato yuz berdi.");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // ── build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF6F7FB), Color(0xFFECEEF5)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacing24, vertical: DesignTokens.spacing32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _GreetingHeader(),
                  const SizedBox(height: DesignTokens.spacing32),
                  _card(),
                  const SizedBox(height: DesignTokens.spacing24),
                  const _VersionLabel(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _card() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(DesignTokens.spacing24),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 24, offset: const Offset(0, 8)),
        ],
      ),
      child: switch (_mode) {
        _Mode.otpPhone => _otpPhoneView(),
        _Mode.otpCode => _otpCodeView(),
        _Mode.login => _loginView(),
        _Mode.register => _registerView(),
      },
    );
  }

  // ── views ─────────────────────────────────────────────────────────────────
  Widget _otpPhoneView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Telefon raqam', style: DesignTokens.headingMedium),
        const SizedBox(height: 4),
        Text('Loginiga uchun telefon raqam talab qilinadi',
            style: DesignTokens.bodySmall.copyWith(color: DesignTokens.textMuted)),
        const SizedBox(height: DesignTokens.spacing24),
        Text('Telefon raqam', style: DesignTokens.caption.copyWith(color: DesignTokens.textSecondary)),
        const SizedBox(height: DesignTokens.spacing8),
        Container(
          decoration: BoxDecoration(
            color: DesignTokens.primaryTint,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
            border: Border.all(color: DesignTokens.primary, width: 2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacing16),
          child: Row(
            children: [
              const Text('+998', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: DesignTokens.spacing8),
              Expanded(
                child: TextField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(9)],
                  decoration: const InputDecoration(
                    hintText: '90 123 45 67',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onSubmitted: (_) => _requestOtp(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: DesignTokens.spacing8),
        Text('Sms kod shu raqamga yuboriladi',
            style: DesignTokens.caption.copyWith(color: DesignTokens.textMuted)),
        _errorText(),
        const SizedBox(height: DesignTokens.spacing16),
        _primaryButton('OTP Yuborish', _loading ? null : _requestOtp),
        const SizedBox(height: DesignTokens.spacing24),
        Container(
          padding: const EdgeInsets.all(DesignTokens.spacing16),
          decoration: BoxDecoration(
            color: DesignTokens.primaryTint,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
          ),
          child: Text(
            "📱 Siz kiritgan raqamga 6 xonali kod yuboriladi. Agar SMS kelmaydigan bo'lsa, 2-3 minutdan keyin qayta urinib ko'ring.",
            style: DesignTokens.bodySmall.copyWith(color: DesignTokens.textSecondary),
          ),
        ),
        const SizedBox(height: DesignTokens.spacing24),
        const _OrDivider(),
        const SizedBox(height: DesignTokens.spacing16),
        _outlinedButton('🔐 Username bilan kirish', () => _switch(_Mode.login)),
      ],
    );
  }

  Widget _otpCodeView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('✓ Kod yuborildi', style: DesignTokens.headingMedium),
        const SizedBox(height: 4),
        Text.rich(TextSpan(
          style: DesignTokens.bodySmall.copyWith(color: DesignTokens.textMuted),
          children: [
            TextSpan(text: _sentPhone, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827))),
            const TextSpan(text: ' raqamiga 6 xonali kod yuboramiz'),
          ],
        )),
        const SizedBox(height: DesignTokens.spacing24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [for (var i = 0; i < 6; i++) _otpBox(i)],
        ),
        _errorText(),
        const SizedBox(height: DesignTokens.spacing16),
        _primaryButton('Tasdiqlash', _loading ? null : () {
          final code = _otp.map((c) => c.text).join();
          if (code.length == 6) _verifyOtp(code);
        }),
        const SizedBox(height: DesignTokens.spacing8),
        Center(
          child: ValueListenableBuilder<int>(
            valueListenable: _cooldown,
            builder: (context, cooldown, _) => TextButton(
              onPressed: cooldown > 0 || _loading ? null : _resend,
              child: Text(cooldown > 0 ? 'Qayta yuborish ($cooldown s)' : 'Qayta yuborish'),
            ),
          ),
        ),
        Center(child: TextButton(onPressed: () => _switch(_Mode.otpPhone), child: const Text('← Orqaga'))),
      ],
    );
  }

  Widget _loginView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _backButton(),
        Text('Kirish', style: DesignTokens.headingMedium),
        const SizedBox(height: DesignTokens.spacing16),
        _field(_username, 'Username', autofillHints: const [AutofillHints.username]),
        const SizedBox(height: DesignTokens.spacing16),
        _passwordField(_password, 'Parol', _obscurePassword, () => setState(() => _obscurePassword = !_obscurePassword)),
        _errorText(),
        const SizedBox(height: DesignTokens.spacing24),
        _primaryButton('Kirish', _loading ? null : _login),
        const SizedBox(height: DesignTokens.spacing16),
        Center(
          child: Wrap(
            children: [
              Text("Akkauntingiz yo'qmi? ", style: DesignTokens.bodySmall.copyWith(color: DesignTokens.textMuted)),
              GestureDetector(
                onTap: () => _switch(_Mode.register),
                child: Text("Ro'yxatdan o'tish",
                    style: DesignTokens.bodySmall.copyWith(color: DesignTokens.primary, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _registerView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _backButton(),
        Text("Ro'yxatdan o'tish", style: DesignTokens.headingMedium),
        const SizedBox(height: DesignTokens.spacing16),
        _field(_name, 'Ism (ixtiyoriy)'),
        const SizedBox(height: DesignTokens.spacing12),
        _field(_username, 'Username'),
        const SizedBox(height: DesignTokens.spacing12),
        _passwordField(_password, 'Parol', _obscurePassword, () => setState(() => _obscurePassword = !_obscurePassword)),
        const SizedBox(height: DesignTokens.spacing12),
        _passwordField(_confirm, 'Parolni tasdiqlang', _obscureConfirm, () => setState(() => _obscureConfirm = !_obscureConfirm)),
        _errorText(),
        const SizedBox(height: DesignTokens.spacing24),
        _primaryButton("Ro'yxatdan o'tish", _loading ? null : _register),
        const SizedBox(height: DesignTokens.spacing16),
        Center(
          child: Wrap(
            children: [
              Text('Allaqachon akkauntingiz bormi? ', style: DesignTokens.bodySmall.copyWith(color: DesignTokens.textMuted)),
              GestureDetector(
                onTap: () => _switch(_Mode.login),
                child: Text('Kirish',
                    style: DesignTokens.bodySmall.copyWith(color: DesignTokens.primary, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── small widgets ───────────────────────────────────────────────────────
  Widget _backButton() => Padding(
        padding: const EdgeInsets.only(bottom: DesignTokens.spacing16),
        child: GestureDetector(
          onTap: () => _switch(_Mode.otpPhone),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.arrow_back, size: 18, color: DesignTokens.textMuted),
            const SizedBox(width: 6),
            Text('Orqaga', style: DesignTokens.bodySmall.copyWith(color: DesignTokens.textMuted)),
          ]),
        ),
      );

  Widget _otpBox(int i) {
    return SizedBox(
      width: 46,
      height: 52,
      child: TextField(
        controller: _otp[i],
        focusNode: _otpFocus[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: const Color(0xFFF7F8FA),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
            borderSide: const BorderSide(color: DesignTokens.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
            borderSide: const BorderSide(color: DesignTokens.primary, width: 2),
          ),
        ),
        onChanged: (v) {
          if (v.isNotEmpty && i < 5) _otpFocus[i + 1].requestFocus();
          if (v.isEmpty && i > 0) _otpFocus[i - 1].requestFocus();
          final code = _otp.map((c) => c.text).join();
          if (code.length == 6 && !_loading) _verifyOtp(code);
        },
      ),
    );
  }

  Widget _field(TextEditingController c, String hint, {Iterable<String>? autofillHints}) {
    return TextField(
      controller: c,
      autofillHints: autofillHints,
      decoration: _inputDecoration(hint),
    );
  }

  Widget _passwordField(TextEditingController c, String hint, bool obscure, VoidCallback toggle) {
    return TextField(
      controller: c,
      obscureText: obscure,
      decoration: _inputDecoration(hint).copyWith(
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          onPressed: toggle,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFFAFAFB),
        contentPadding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacing16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
          borderSide: const BorderSide(color: DesignTokens.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
          borderSide: const BorderSide(color: DesignTokens.primary, width: 2),
        ),
      );

  Widget _primaryButton(String label, VoidCallback? onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignTokens.primary,
          disabledBackgroundColor: DesignTokens.primary.withValues(alpha: 0.4),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DesignTokens.radiusMedium)),
        ),
        child: _loading
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.white)))
            : Text(label, style: const TextStyle(color: DesignTokens.white, fontWeight: FontWeight.w700, fontSize: 15)),
      ),
    );
  }

  Widget _outlinedButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 13),
          side: const BorderSide(color: DesignTokens.border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DesignTokens.radiusMedium)),
        ),
        child: Text(label, style: DesignTokens.bodyMedium.copyWith(color: DesignTokens.textSecondary, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _errorText() => _error == null
      ? const SizedBox.shrink()
      : Padding(
          padding: const EdgeInsets.only(top: DesignTokens.spacing12),
          child: Text(_error!, style: DesignTokens.bodySmall.copyWith(color: DesignTokens.error)),
        );
}

/// Static greeting above the auth card ("👋 Salom" + subtitle). Extracted as a
/// `const` widget so the per-keystroke / per-cooldown rebuilds of the stateful
/// screen never rebuild it.
class _GreetingHeader extends StatelessWidget {
  const _GreetingHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('👋 Salom',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
        const SizedBox(height: DesignTokens.spacing8),
        Text("Andoza AI-ga xush kelibsiz",
            style: DesignTokens.bodyLarge.copyWith(color: DesignTokens.textMuted)),
      ],
    );
  }
}

/// Static app-version footnote below the auth card. `const` for the same reason.
class _VersionLabel extends StatelessWidget {
  const _VersionLabel();

  @override
  Widget build(BuildContext context) {
    return Text('AndozaAI v1.0.0',
        style: DesignTokens.caption.copyWith(color: DesignTokens.textMuted));
  }
}

/// Static "yoki" divider between the OTP and username entry points.
class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(child: Divider(color: DesignTokens.border)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacing12),
        child: Text('yoki', style: DesignTokens.caption.copyWith(color: DesignTokens.textMuted)),
      ),
      const Expanded(child: Divider(color: DesignTokens.border)),
    ]);
  }
}
