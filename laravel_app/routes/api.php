<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\NotificationController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RatingController;
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
use App\Http\Controllers\HouseholdAssistantController;


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/household-assistants', [HouseholdAssistantController::class, 'index']);
Route::get('/assistants/{id}', [HouseholdAssistantController::class, 'show']);
Route::post('/store', [HouseholdAssistantController::class, 'store']);

Route::post('/orders', [OrderController::class, 'create']);
Route::get('/getRiwayat', [OrderController::class, 'getOrders']);

Route::get('/getNotifications', [NotificationController::class, 'getNotif']);

Route::get('/ratings', [RatingController::class, 'index']);
Route::post('/ratings', [RatingController::class, 'store']);
Route::get('/ratings/{id}', [RatingController::class, 'show']);
