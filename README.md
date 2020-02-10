# Mars Water Rover

This is an application to process inputs from a mars rover sensor which tracks water concentration in grid locations.

This application is made with Elixir and Plug for serving the api and the html.

## Usage

All public funcitons are well documented and have running examples (doctest) to explain the usage and the expected result.

## Runing the web server

You can run a cowboy webserve to vizualize a Heatmap for an specific input.

First make sure you have all the dependencies installed and compiled:

```shell
mix deps.get
```

Then run the following command:

```shell
mix run --no-halt
```

### Concentration api

I create a simple concentration api. It is a get endpoing you can use to process an input. You can try it with curl.

```curl
curl --location --request GET 'http://localhost:4001/api/concentrations?input=3%205%205%203%201%202%200%204%201%201%203%202%202%203%202%204%203%200%202%203%203%202%201%200%202%204%203'
```

### Heatmap chart

The ui is very simple and only contains the chart. I used d3.js called from a static html. The input must be given as a query string. Here is a link with a sample input:

[http://localhost:4001/pages/index.html?input=16%204%202%203%202%201%204%204%202%200%203%204%201%201%202%203%204%204](http://localhost:4001/pages/index.html?input=16%204%202%203%202%201%204%204%202%200%203%204%201%201%202%203%204%204)

Note that I replace the first argument by the number of locations in the grid, making sure that the heat map will always be filled.

### Running the automated tests

The `WaterRover` module is extensively tested. All public funcitons have doctest (:hearts: executable documentation :hearts:) and ExUnit tests. The tests are in `test/water_rover_test_exs` and can be run with `mix test`.

PS: I didn't write tests for the web layer, just because I kept it too basic. In the real world there would be tests for it.
