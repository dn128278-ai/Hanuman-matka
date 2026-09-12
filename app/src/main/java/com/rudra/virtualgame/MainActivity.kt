package com.rudra.virtualgame

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val tvWallet = findViewById<TextView>(R.id.tvWallet)
        val btnPlay = findViewById<Button>(R.id.btnPlay)
        val btnLogout = findViewById<Button>(R.id.btnLogout)

        btnPlay.setOnClickListener {
            Toast.makeText(this, "Game Simulation Starting...", Toast.LENGTH_SHORT).show()
        }

        btnLogout.setOnClickListener {
            val intent = Intent(this, LoginActivity::class.java)
            startActivity(intent)
            finish()
        }
    }
}

