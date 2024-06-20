<?php
namespace App\Http\Controllers;

use App\Models\HouseholdAssistant;
use Illuminate\Http\Request;

class HouseholdAssistantController extends Controller
{
    public function index()
    {
        $assistants = HouseholdAssistant::all();
        return response()->json($assistants);
    }
    public function show($id)
    {
        $assistant = HouseholdAssistant::find($id);
        return response()->json($assistant);
    }

    public function store(Request $request)
    {
        // Validate the request data
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:household_assistants,email',
            'phone' => 'required|string|max:20',
            'speciality' => 'required|string|max:255',
        ]);

        // Create a new HouseholdAssistant
        $householdAssistant = HouseholdAssistant::create([
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'speciality' => $request->speciality,
        ]);

        // Return a response, perhaps the created resource or a success message
        return response()->json([
            'message' => 'Household Assistant created successfully!',
            'data' => $householdAssistant
        ], 201);
    }
}


