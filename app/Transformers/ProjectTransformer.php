<?php

namespace App\Transformers;

use App\Entities\Project;

class ProjectTransformer
{
    public function transform(Project $project): array
    {
        return [
            'id' => $project->getId(),
            'title' => $project->getTitle(),
            'description' => $project->getDescription(),
        ];
    }

    public function transformCollection(array $projects): array
    {
        return array_map([$this, 'transform'], $projects);
    }
}
