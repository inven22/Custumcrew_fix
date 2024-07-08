<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\NotificationController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RatingController;
use App\Http\Controllers\HouseholdAssistantController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::post('/auth/register', [AuthController::class, 'register']);
Route::post('/auth/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->post('/auth/validate-token', [AuthController::class, 'validateToken']);

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::middleware('auth:sanctum')->get('/profile', [AuthController::class, 'profile']);

Route::middleware('auth:sanctum')->get('/get-self-household-assistant', [HouseholdAssistantController::class, 'showById']);

Route::get('/household-assistants', [HouseholdAssistantController::class, 'index']);
Route::get('/household-assistants-category', [HouseholdAssistantController::class, 'category']);
Route::get('/assistants/{id}', [HouseholdAssistantController::class, 'show']);
Route::post('/store', [HouseholdAssistantController::class, 'store']);
Route::put('/household-assistants/{id}', [HouseholdAssistantController::class, 'update']);
Route::delete('/household-assistants/{id}', [HouseholdAssistantController::class, 'destroy']);

Route::post('/orders', [OrderController::class, 'create']);
Route::get('/getRiwayat', [OrderController::class, 'getOrders']);   

Route::get('/getNotifications', [NotificationController::class, 'getNotif']);

Route::get('/ratings', [RatingController::class, 'index']);
Route::post('/ratings_store', [RatingController::class, 'store']);
Route::get('/ratings/{id}', [RatingController::class, 'show']);

Route::get('/getRatings/{id}', [RatingController::class, 'getHouseholdRating']);
// Route::middleware('auth:sanctum')->get('/getRatings/{id}', [RatingController::class, 'getHouseholdRating']);
Route::get('/getTotalOrder/{id}', [OrderController::class, 'getHouseholdTotalOrder']);