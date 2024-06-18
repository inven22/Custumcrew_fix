<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notifications extends Model
{
    use HasFactory;
    protected $fillable = ['order_id', 'isi'];
    public function order()
    {
        return $this->belongsTo(Order::class);
    }

    public $timestamps = false;
}
