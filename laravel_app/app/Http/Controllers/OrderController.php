<?php


namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Order;

class OrderController extends Controller
{
    public function create(Request $request)
    {
        $order = new Order();
        $order->user_id = $request->user_id;
        $order->household_assistant_id = $request->household_assistant_id;
        $order->service_date = $request->service_date;
        $order->created_at = new \DateTime();
        $order->updated_at = new \DateTime();

        if ($order->save()) {
            return response()->json(['message' => 'Order berhasil dibuat'], 200);
        } else {
            return response()->json(['message' => 'Gagal membuat order'], 500);
        }
    }

    public function getOrders()
    {
        $orders = Order::with('householdAssistant:id,name')
                   ->select('id', 'household_assistant_id', 'service_date')
                   ->get()      
                   ->map(function ($order) {
                       return [
                           'id' => $order->id,
                           'household_assistant_id' => $order->household_assistant_id,
                           'household_assistant_name' => $order->householdAssistant->name,
                           'service_date' => $order->service_date,
                       ];
                   });

    return response()->json($orders, 200);
    }
}