<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class RatingController extends Controller
{
    public function store(Request $request)
    {
        $rating = Rating::create($request->all());
        return response()->json($rating, 201);
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
