<?php

namespace App\Providers;

use App\Http\Controllers\ProjectController;
use App\Repositories\ProjectRepository;
use App\Repositories\ProjectRepositoryInterface;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(ProjectRepositoryInterface::class, ProjectRepository::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Route::get('api/projects', [ProjectController::class, 'index']);
    }
}
