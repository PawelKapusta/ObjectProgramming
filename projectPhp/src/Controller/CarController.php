<?php

namespace App\Controller;

use App\Entity\Car;
use App\Form\CarType;
use App\Repository\CarRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Encoder\XmlEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;

#[Route('/car')]
class CarController extends AbstractController
{

	public function __construct() {
		$this->encoders = [new XmlEncoder(), new JsonEncoder()];
		$this->normalizers = [new ObjectNormalizer()];
		$this->serializer = new Serializer($this->normalizers, $this->encoders);
	}

    #[Route('/', name: 'app_car_index', methods: ['GET'])]
    public function index(CarRepository $carRepository): Response
    {
	    $returnedJson = $this->serializer->serialize($carRepository->findAll(), 'json');
	    return new Response($returnedJson);
    }

    #[Route('/new', name: 'app_car_new', methods: ['POST'])]
    public function new(Request $request, CarRepository $carRepository): Response
    {
        $car = new Car();
        $form = $this->createForm(CarType::class, $car);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $carRepository->add($car);
        }

        return new Response();
    }

    #[Route('/{id}', name: 'app_car_show', methods: ['GET'])]
    public function show(Car $car): Response
    {
        $returnedJson = $this->serializer->serialize($car, 'json');
	return new Response($returnedJson);
    }

    #[Route('/{id}/edit', name: 'app_car_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Car $car, CarRepository $carRepository): Response
    {
        $form = $this->createForm(CarType::class, $car);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $carRepository->add($car);
        }

        return new Response();
    }

    #[Route('/{id}', name: 'app_car_delete', methods: ['POST'])]
    public function delete(Request $request, Car $car, CarRepository $carRepository): Response
    {
        $carRepository->remove($car);
        return new Response();
    }
}
