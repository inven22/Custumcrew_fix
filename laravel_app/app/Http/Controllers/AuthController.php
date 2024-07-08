<?php

namespace App\Http\Controllers;

use App\Models\HouseholdAssistant;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    //
    public function register(Request $req)
    {
        //valdiate
        $rules = [
            'name' => 'required|string',
            'email' => 'required|string|unique:users',
            'password' => 'required|string|min:6'
        ];
        $validator = Validator::make($req->all(), $rules);
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }
        //create new user in users table
        $user = User::create([  
            'name' => $req->name,
            'email' => $req->email,
            'password' => Hash::make($req->password)
        ]);
        $token = $user->createToken('Personal Access Token')->plainTextToken;
        $response = ['user' => $user, 'token' => $token];
        return response()->json($response, 200);
    }

    public function login(Request $req)
    {
        // validate inputs
        $rules = [
            'email' => 'required',
            'password' => 'required|string'
        ];
        $req->validate($rules);
        // find user email in users table
        $user = User::where('email', $req->email)->first();
        // if user email found and password is correct
        if ($user && Hash::check($req->password, $user->password)) {
            $token = $user->createToken('Personal Access Token')->plainTextToken;
            $response = ['user' => $user, 'token' => $token];
            return response()->json($response, 200);
        }
        $response = ['message' => 'Incorrect email or password'];
        return response()->json($response, 400);
    }

    public function validateToken(Request $request)
    {
        if (Auth::guard('sanctum')->check()) {
            return response()->json(['valid' => true], 200);
        } else {
            return response()->json(['valid' => false], 401);
        }
    }

    public function registerHouseholdAssistant(Request $req)
{
    // Validate input
    $rules = [
        'speciality' => 'required|string'
    ];
    $validator = Validator::make($req->all(), $rules);
    if ($validator->fails()) {
        return response()->json($validator->errors(), 400);
    }

    $user = $req->user();

    // Create a new HouseholdAssistant
    $household_assistant = new HouseholdAssistant();
    $household_assistant->user_id = $user->id;
    $household_assistant->name = $user->name;  // Copy the name from User
    $household_assistant->speciality = $req->speciality;
    $household_assistant->biography = "hi";
    // Update user role
    $user->role = 'household_assistant';

    // Save both the user and household assistant
    $user->save();
    $household_assistant->save();

    return response()->json(['message' => 'User registered as household assistant successfully'], 200);
}



    public function profile(Request $request){
        $user = $request->user();
        try {
            if ($user) {
                return response()->json(['user' => $user], 200);
            } else {
                return response()->json(['message' => 'User not found'], 404);
            }
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Server Error'], 500);
        }
    }

    public function updateProfile(Request $req)
    {
        $user = $req->user();

        // Validate inputs
        $rules = [
            'name' => 'sometimes|required|string',
            'email' => 'sometimes|required|string|email|unique:users,email,' . $user->id,
            'password' => 'sometimes|required|string|min:6',
            'alamat' => 'sometimes|required|string',
            'phone' => 'sometimes|required|string'
        ];
        $validator = Validator::make($req->all(), $rules);
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        // Update user data
        if ($req->has('name')) {
            $user->name = $req->name;
        }
        if ($req->has('email')) {
            $user->email = $req->email;
        }
        if ($req->has('password')) {
            $user->password = Hash::make($req->password);
        }
        if ($req->has('alamat')) {
            $user->alamat = $req->alamat;
        }
        if ($req->has('phone')) {
            $user->phone = $req->phone;
        }
        $user->save();

        return response()->json(['user' => $user, 'message' => 'Profile updated successfully'], 200);
    }
}
