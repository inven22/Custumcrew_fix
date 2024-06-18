<?php


namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Order;

class OrderController extends Controller
{
    public function create(Request $request)
    {
        // $request->validate([
        //     'household_assistant_id' => 'required|exists:household_assistants,id',
        //     'service_date' => 'required|date',
        // ]);

        $order = new Order;
        $order->household_assistant_id = $request->household_assistant_id;
        $order->service_date = $request->service_date;

        if ($order->save()) {
            return response()->json(['message' => 'Order berhasil dibuat'], 200);
        } else {
            return response()->json(['message' => 'Gagal membuat order'], 500);
        }
    }

    public function getOrders()
    {
        $orders = Order::select('household_assistant_id', 'service_date')->get();

        return response()->json($orders, 200);
    }
}