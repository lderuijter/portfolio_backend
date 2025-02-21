<?php

namespace Database\Seeders;

use App\Entities\Project;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Exception\ORMException;
use Doctrine\ORM\OptimisticLockException;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * @throws OptimisticLockException
     * @throws ORMException
     */
    public function run(EntityManager $em): void
    {
        $project = new Project();
        $project->setTitle('Portfolio Website');
        $project->setDescription('A portfolio built with Laravel and Vue.');
        $em->persist($project);
        $em->flush();
    }
}

