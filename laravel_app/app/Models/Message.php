<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Message extends Model
{
    use HasFactory;

    protected $fillable = ['order_id', 'content'];

    public function order()
    {
        return $this->belongsTo(Order::class);
    }
}

