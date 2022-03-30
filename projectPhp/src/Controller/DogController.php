<?php

namespace App\Controller;

use App\Entity\Dog;
use App\Form\DogType;
use App\Repository\DogRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Encoder\XmlEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;

#[Route('/dog')]
class DogController extends AbstractController
{
	public function __construct() {
		$this->encoders = [new XmlEncoder(), new JsonEncoder()];
		$this->normalizers = [new ObjectNormalizer()];
		$this->serializer = new Serializer($this->normalizers, $this->encoders);
	}
    #[Route('/', name: 'app_dog_index', methods: ['GET'])]
    public function index(DogRepository $dogRepository): Response
    {
        $returnedJson = $this->serializer->serialize($dogRepository->findAll(), 'json');

	return new Response($returnedJson); 
    }

    #[Route('/new', name: 'app_dog_new', methods: ['POST'])]
    public function new(Request $request, DogRepository $dogRepository): Response
    {
        $dog = new Dog();
        $form = $this->createForm(DogType::class, $dog);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $dogRepository->add($dog);
        }

        return new Response();
    }

    #[Route('/{id}', name: 'app_dog_show', methods: ['GET'])]
    public function show(Dog $dog): Response
    {
        $returnedJson = $this->serializer->serialize($dog, 'json');
	return new Response($returnedJson);
    }

    #[Route('/{id}/edit', name: 'app_dog_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Dog $dog, DogRepository $dogRepository): Response
    {
        $form = $this->createForm(DogType::class, $dog);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $dogRepository->add($dog);
        }

        return new Response();
    }

    #[Route('/{id}', name: 'app_dog_delete', methods: ['POST'])]
    public function delete(Request $request, Dog $dog, DogRepository $dogRepository): Response
    {
       	$dogRepository->remove($dog);

        return new Response();
    }
}
