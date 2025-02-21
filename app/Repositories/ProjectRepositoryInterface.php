<?php

namespace App\Repositories;

use Illuminate\Http\JsonResponse;

interface ProjectRepositoryInterface
{
    public function getAll(): array;
}
