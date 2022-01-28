# genARTrated gallery

## Compilation
The gallery for genARTrated is created using <https://github.com/soyaine/horcrux> and can be generated with Make:
`make gallery-compile`

## Viewing
### GitHub Pages
Once compiled, the gallery can be viewed online at <https://art.toozej.dev> which utilizes generation and hosting via GitHub Pages, and of course a custom domain name

### Local
To view and/or iterate on the genARTrated gallery locally, you can use Make:
`make gallery-view`

This uses a modified version of <https://github.com/madduci/docker-github-pages> Dockerized github-pages Ruby gem and Jekyll to display a live-refreshing web server. Once the `make gallery-view` output is showing the logs from Jekyll running the web server, navigate to <http://localhost:8080> in your web browser to view.
