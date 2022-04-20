package main

import (
	"fmt"
	"github.com/labstack/echo/v4"
	"io/ioutil"
	"net/http"
)

func proxy() string {
	url := "https://api.openweathermap.org/data/2.5/weather?lat=50.07069&lon=21.70062&appid=411cdd6b354960a600919773ae3b4bc4"
	response, error := http.Get(url)
	if error != nil {
		fmt.Println("Error from response!")
	}
	defer response.Body.Close()
	body, error := ioutil.ReadAll(response.Body)
	return string(body)
}

func main() {
	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		response := proxy()
		return c.JSON(http.StatusOK, response)
	})
	e.Logger.Fatal(e.Start(":1323"))
}
