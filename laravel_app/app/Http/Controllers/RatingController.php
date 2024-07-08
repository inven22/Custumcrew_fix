<?php

namespace App\Http\Controllers;

use App\Models\Rating;
use Illuminate\Http\Request;
use App\Models\HouseholdAssistant;
use App\Models\Order;
class RatingController extends Controller
{
    public function index()
    {
        $ratings = Rating::all();
        return response()->json($ratings);
    }

    public function store(Request $request)
    {
        $request->validate([
            'order_id' => 'required|exists:orders,id',
            'rating' => 'required|numeric|min:1|max:5',
        ]);

        $order = Order::find($request->input('order_id'));

        if (!$order) {
            return response()->json(['error' => 'Order not found'], 404);
        }

        // Save rating to database
        $rating = new Rating();
        $rating->order_id = $request->input('order_id');
        $rating->rating = $request->input('rating');
        $rating->save();

        return response()->json(['message' => 'Rating stored successfully'], 200);
    }

    public function show($id)
    {
        $rating = Rating::find($id);
        if (!$rating) {
            return response()->json(['message' => 'Rating not found'], 404);
        }
        return response()->json($rating);
    }

    public function getHouseholdRating($id)
    {
        // $user = auth()->user(); // Mengambil pengguna yang terautentikasi

        // if (!$user) {
        //     return response()->json(['error' => 'Unauthorized'], 401);
        // }
        // $user = $request->user();
        $orders = Order::where('household_assistant_id', $id)->get();

        // Collect order ids
        $orderIds = $orders->pluck('id')->toArray();

        // Retrieve ratings based on collected order ids
        $ratings = Rating::whereIn('order_id', $orderIds)->get();

        if ($ratings->isEmpty()) {
            return response()->json(['average_rating' => 0]);
        }

        $totalRating = $ratings->sum('rating');
        $averageRating = $totalRating / $ratings->count();

        return response()->json(['average_rating' => $averageRating]);
    }


}
