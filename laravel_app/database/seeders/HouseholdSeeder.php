<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class HouseholdSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Menyimpan data household assistant ke dalam database
        DB::table('household_assistants')->insert([
            [
                'name' => 'Jane Smith',
                'speciality' => 'cleaning',
                'biography' => 'Experienced in house cleaning and maintenance.',
                'order_count' => 10,
                'user_id' => 2, // Sesuaikan dengan id user Jane Smith
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Alice Johnson',
                'speciality' => 'childcare',
                'biography' => 'Certified in childcare and early childhood education.',
                'order_count' => 5,
                'user_id' => 3, // Sesuaikan dengan id user Alice Johnson
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
