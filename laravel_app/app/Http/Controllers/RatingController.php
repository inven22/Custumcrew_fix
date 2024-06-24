<?php

namespace App\Http\Controllers;
use App\Models\Rating;
use Illuminate\Http\Request;

class RatingController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'order_id' => 'required|integer',
            'user_id' => 'required|integer',
            'rating' => 'required|numeric|min:1|max:5',
        ]);

        $rating = Rating::create([
            'order_id' => $request->order_id,
            'user_id' => $request->user_id,
            'rating' => $request->rating,
        ]);

        return response()->json(['message' => 'Rating saved successfully', 'rating' => $rating], 201);
    }

    public function index()
    {
        $ratings = Rating::all();
        return response()->json($ratings);
    }

    public function show($id)
    {
        $rating = Rating::find($id);
        return response()->json($rating);
    }
}
