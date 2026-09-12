package com.rudra.virtualgame

import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import kotlin.random.Random

class GameActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_game)

        val etNumber = findViewById<EditText>(R.id.etNumber)
        val btnSubmit = findViewById<Button>(R.id.btnSubmit)

        btnSubmit.setOnClickListener {
            val inputStr = etNumber.text.toString().trim()

            if (inputStr.isEmpty()) {
                Toast.makeText(this, "Please enter a number", Toast.LENGTH_SHORT).show()
            } else {
                val userNumber = inputStr.toInt()
                if (userNumber in 0..9) {
                    val winningNumber = Random.nextInt(0, 10)
                    if (userNumber == winningNumber) {
                        Toast.makeText(this, "Congratulations! You Won! Winning Number: $winningNumber", Toast.LENGTH_LONG).show()
                    } else {
                        Toast.makeText(this, "You Lost! Winning Number was: $winningNumber", Toast.LENGTH_LONG).show()
                    }
                } else {
                    Toast.makeText(this, "Please enter a number between 0 and 9", Toast.LENGTH_SHORT).show()
                }
            }
        }
    }
}

