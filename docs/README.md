# Setup New Box

1) Create a new branch named `temp` from the `master` branch
2) Switch to `temp` so that this README.md is from that branch
3) Change the IP address in [Build-New-Host.yml](https://github.com/Lotus-King-Research/Padma-Infra/blob/temp/.github/workflows/Build-New-Host.yml)
4) Change the URL in [Padma-API.conf](https://github.com/Lotus-King-Research/Padma-Infra/blob/temp/Padma-API.conf)
5) Change the URL in [Padma-Frontend.conf](https://github.com/Lotus-King-Research/Padma-Infra/blob/temp/Padma-Frontend.conf)
6) Change the domain names in [build.sh](https://github.com/Lotus-King-Research/Padma-Infra/blob/7b9437b54597a1484eb06677e0b659f5e703cf52/build.sh#L41)
7) Create a new branch `_deploy_` from `temp` and the deploy will take place
8) Watch it happen from Actions tab
9) SSH into the box and run `sudo certbot --nginx`

**NOTE: Cloudflare DNS has to be updated if the domain is new.**
