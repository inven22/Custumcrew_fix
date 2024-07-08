<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Menyimpan data user ke dalam database
        DB::table('users')->insert([
            [
                'name' => 'John Doe',
                'email' => 'john.doe@example.com',
                'password' => Hash::make('password'),
                'role' => 'user',
                'alamat' => '123 Main St',
                'phone' => '1234567890',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Jane Smith',
                'email' => 'jane.smith@example.com',
                'password' => Hash::make('password'),
                'role' => 'household_assistant',
                'alamat' => '456 Elm St',
                'phone' => '0987654321',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Alice Johnson',
                'email' => 'alice.johnson@example.com',
                'password' => Hash::make('password'),
                'role' => 'household_assistant',
                'alamat' => '789 Maple St',
                'phone' => '1122334455',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
