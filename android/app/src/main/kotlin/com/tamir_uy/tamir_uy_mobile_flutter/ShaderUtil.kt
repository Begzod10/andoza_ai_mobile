package com.tamir_uy.tamir_uy_mobile_flutter

import android.opengl.GLES20

/** Minimal GLSL compile helper for the camera-background renderer. */
object ShaderUtil {

    /** Compiles a shader of [type] from [code]; returns 0 on failure. */
    fun loadShader(type: Int, code: String): Int {
        var shader = GLES20.glCreateShader(type)
        GLES20.glShaderSource(shader, code)
        GLES20.glCompileShader(shader)

        val compileStatus = IntArray(1)
        GLES20.glGetShaderiv(shader, GLES20.GL_COMPILE_STATUS, compileStatus, 0)
        if (compileStatus[0] == 0) {
            // TODO(real-device): surface glGetShaderInfoLog when debugging on hardware.
            GLES20.glDeleteShader(shader)
            shader = 0
        }
        return shader
    }
}
