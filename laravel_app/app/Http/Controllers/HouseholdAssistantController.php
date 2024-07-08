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
    public function showById(Request $request)
    {
        $userId = $request->query('user_id');
        $householdAssistants = HouseholdAssistant::where('user_id', $userId)->first();
        if ($householdAssistants){
            return response()->json($householdAssistants);
        }
        return response()->json("gak masuk datanya");
    }
    public function category(Request $request)
    {
        $speciality = $request->query('speciality', 'cleaning');
        $assistants = HouseholdAssistant::where('speciality', $speciality)->get();
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

    public function update(Request $request, $id)
{
    // Validasi data masukan
    $request->validate([
        'name' => 'sometimes|required|string|max:255',
        'email' => 'sometimes|required|email|unique:household_assistants,email,' . $id,
        'phone' => 'sometimes|required|string|max:20',
        'speciality' => 'sometimes|required|string|max:255',
    ]);

    // Temukan HouseholdAssistant berdasarkan ID
    $householdAssistant = HouseholdAssistant::find($id);

    // Periksa apakah HouseholdAssistant ditemukan
    if (!$householdAssistant) {
        return response()->json([
            'message' => 'Household Assistant not found!'
        ], 404);
    }

    // Update data HouseholdAssistant
    $householdAssistant->update([
        'name' => $request->has('name') ? $request->name : $householdAssistant->name,
        'email' => $request->has('email') ? $request->email : $householdAssistant->email,
        'phone' => $request->has('phone') ? $request->phone : $householdAssistant->phone,
        'speciality' => $request->has('speciality') ? $request->speciality : $householdAssistant->speciality,
    ]);

    // Kembalikan respons dengan data yang diperbarui
    return response()->json([
        'message' => 'Household Assistant updated successfully!',
        'data' => $householdAssistant
    ], 200);
}

public function destroy($id)
{
    // Temukan HouseholdAssistant berdasarkan ID
    $householdAssistant = HouseholdAssistant::find($id);

    // Periksa apakah HouseholdAssistant ditemukan
    if (!$householdAssistant) {
        return response()->json([
            'message' => 'Household Assistant not found!'
        ], 404);
    }

    // Hapus HouseholdAssistant
    $householdAssistant->delete();

    // Kembalikan respons
    return response()->json([
        'message' => 'Household Assistant deleted successfully!'
    ], 200);
}


}


