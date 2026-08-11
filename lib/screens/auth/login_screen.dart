import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      backgroundColor: DesignTokens.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Andoza AI',
                textAlign: TextAlign.center,
                style: DesignTokens.headingLarge.copyWith(
                  color: DesignTokens.primary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      DesignTokens.radiusLarge,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacing16,
                    vertical: DesignTokens.spacing12,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      DesignTokens.radiusLarge,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacing16,
                    vertical: DesignTokens.spacing12,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    tooltip: _obscurePassword ? 'Show password' : 'Hide password',
                    onPressed: () => setState(
                      () => _obscurePassword = !_obscurePassword,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing24),
              ElevatedButton(
                onPressed: authState is AuthLoading
                    ? null
                    : () => _handleLogin(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: DesignTokens.primary,
                  padding: const EdgeInsets.symmetric(
                    vertical: DesignTokens.spacing12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      DesignTokens.radiusLarge,
                    ),
                  ),
                ),
                child: authState is AuthLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        'Login',
                        style: DesignTokens.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
              if (authState is AuthError) ...[
                const SizedBox(height: DesignTokens.spacing16),
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing12),
                  decoration: BoxDecoration(
                    color: DesignTokens.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      DesignTokens.radiusMedium,
                    ),
                  ),
                  child: Text(
                    authState.message,
                    style: DesignTokens.bodySmall.copyWith(
                      color: DesignTokens.error,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    ref.read(authStateProvider.notifier).login(email, password);
  }
}
