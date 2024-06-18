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
}


