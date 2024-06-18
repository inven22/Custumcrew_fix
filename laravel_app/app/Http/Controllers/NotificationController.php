<?php

namespace App\Http\Controllers;
use App\Models\Notifications;
use Illuminate\Http\Request;

class NotificationController extends Controller
{
    public function getNotif(){
        $notif = Notifications::select('order_id', 'isi')->get();
        return response()->json($notif, 200);
    }
}
