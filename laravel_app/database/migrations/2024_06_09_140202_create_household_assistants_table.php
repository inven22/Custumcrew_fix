<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHouseholdAssistantsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('household_assistants', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('speciality');
            $table->text('biography')->nullable();
            $table->integer('order')->nullable();
            $table->string('email')->unique();
            $table->string('phone');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('household_assistants');
    }
}
