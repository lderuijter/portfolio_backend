<?php

namespace App\Http\Controllers;

use App\Repositories\ProjectRepositoryInterface;
use App\Transformers\ProjectTransformer;
use Illuminate\Http\JsonResponse;

class ProjectController extends Controller
{
    public function __construct(
        private readonly ProjectRepositoryInterface $projectRepository,
        private readonly ProjectTransformer $projectTransformer,
    ) {}

    public function index(): JsonResponse
    {
        $projects = $this->projectRepository->getAll();

        $transformedProjects = $this->projectTransformer->transformCollection($projects);

        return response()->json($transformedProjects);
    }
}
