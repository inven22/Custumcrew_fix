<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;

    protected $fillable = ['household_assistant_id', 'service_date'];
    public $timestamps = false;
    public function householdAssistant()
    {
        return $this->belongsTo(HouseholdAssistant::class);
    }

    public function messages()
    {
        return $this->hasMany(Message::class);
    }

    public function ratings()
    {
        return $this->hasMany(Rating::class);
    }
}
