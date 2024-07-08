<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HouseholdAssistant extends Model
{
    use HasFactory;
    
    protected $fillable = ['user_id', 'name', 'speciality', 'biography', 'order_count'];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function orders()
    {
        return $this->hasMany(Order::class);
    }

    public function ratings()
    {
        return $this->hasManyThrough(Rating::class, Order::class);

    }
}