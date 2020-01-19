# Docker image for Mapbox's Tippecanoe + SQLite3
*Note:* This image is a small update of the following image: [https://github.com/jskeates/docker-tippecanoe](https://github.com/jskeates/docker-tippecanoe)

A convenient toolbox for working with vector tiles for 51.1MB only.

The currently built version at the `latest` tag is based on commit `065cc1d` (31 Oct 2019) of Tippecanoe.

This image contains:
- **[Mapbox's Tippecanoe](https://github.com/mapbox/tippecanoe)**: the 5 tools in the Tippecanoe suite (`tippecanoe`, `tippecanoe-enumerate`, `tippecanoe-decode`, `tippecanoe-json-tool` & `tile-join`).  
The version is based on commit `065cc1d` (31 Oct 2019).
- **[SQLite 3](https://sqlite.org/index.html)**: the version 3.30 of the SQL database engine. This is included in the image to provide easy edition of mbtiles files produced by Tippecanoe.

## Usage
Run with `docker run`, mounting a local directory or use Docker volumes as needed wth `-v`. See below for specific examples.  
By default, processes will be run with the `tippecanoe` user in its home directory: `/home/tippecanoe`.

### Interactive Mode with `bash`
Bash is preinstalled in the image.
```shell
docker run -it -v $HOME/tippecanoe:/home/tippecanoe strikehawk/tippecanoe:latest bash
bash-5.0$ tippecanoe -h
tippecanoe: unrecognized option: h
Usage: tippecanoe --output=output.mbtiles [--name=...] [--layer=...]
...
```

### Non-interactive: Directly Invoke Tippecanoe
Alternatively, you can run `tippecanoe` or any other tool directly.
```shell
docker run -it -v $HOME/tippecanoe:/home/tippecanoe strikehawk/tippecanoe:latest tippecanoe -o output.mbtiles input.geojson
```

## Building A Different Version Of Tippecanoe
To build a different version of Tippecanoe, set the `TIPPECANOE_VERSION` build-arg when building the image.

For building on a specific tag:
```shell
git clone https://github.com/strikehawk/tippecanoe-docker.git  
docker build --build-arg TIPPECANOE_VERSION=tag/1.14.0 .
```

For building on a specific commit:
```shell
git clone https://github.com/strikehawk/tippecanoe-docker.git  
docker build --build-arg TIPPECANOE_VERSION=065cc1d78d662ec21620596e07749c02a941337f .
```

Note that different versions may have different dependency requirements, so the build may fail, or the build output may be broken.

## Using The Tools
### Tippecanoe
See [https://github.com/mapbox/tippecanoe](https://github.com/mapbox/tippecanoe) for examples on using the Tippecanoe suite.  
The following links provide direct access to the description of each tool:  
- [tippecanoe](https://github.com/mapbox/tippecanoe#examples)
- [tile-join](https://github.com/mapbox/tippecanoe#tile-join)
- [tippecanoe-enumerate](https://github.com/mapbox/tippecanoe#tippecanoe-enumerate)
- [tippecanoe-decode](https://github.com/mapbox/tippecanoe#tippecanoe-decode)
- [tippecanoe-json-tool](https://github.com/mapbox/tippecanoe#tippecanoe-json-tool)

### SQLite 3
Vector Tiles [MBTiles files](https://github.com/mapbox/mbtiles-spec) are SQLite databases. Using `sqlite3` allows to modify the database after running `tippecanoe`.  
For instance, changing the starting center of tile dataset can be done using the following command:
```shell
docker run -it -v $HOME/tippecanoe:/home/tippecanoe strikehawk/tippecanoe:latest bash
bash-5.0$ sqlite3 output.mbtiles "UPDATE main.metadata SET value='0,0,2' where name ='center';"
```

For those wanting a graphical interface, [DB Browser for SQLite](https://github.com/sqlitebrowser/sqlitebrowser) could be of interest.