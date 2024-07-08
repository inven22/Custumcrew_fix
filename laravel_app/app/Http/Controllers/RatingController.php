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
        $validatedData = $request->validate([
            'order_id' => 'required|exists:orders,id',
            'rating' => 'required|integer|between:1,5',
            'comment' => 'nullable|string',
        ]);

        $rating = Rating::create([
            'order_id' => $validatedData['order_id'],
            'rating' => $validatedData['rating'],
            'comment' => $validatedData['comment'],
        ]);

        return response()->json(['message' => 'Rating saved successfully', 'rating' => $rating], 201);
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
