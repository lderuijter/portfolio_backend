<?php

namespace App\Repositories;

use App\Entities\Project;
use Doctrine\ORM\EntityManagerInterface;
use Illuminate\Http\JsonResponse;

readonly class ProjectRepository implements ProjectRepositoryInterface
{

    public function __construct(
        private EntityManagerInterface $entityManager
    ) {}

    public function getAll(): array
    {
        $queryBuilder = $this->entityManager->createQueryBuilder();
        $queryBuilder->select('p')->from(Project::class, 'p');

        return $queryBuilder->getQuery()->getResult();
    }
}
