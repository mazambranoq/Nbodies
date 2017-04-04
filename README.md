# Taller de transformaciones

## Propósito

Estudiar algunas aplicaciones de las transformaciones geométricas.

## Tareas

1. Implemente una demo (Processing o p5.js) de un grafo de escena cualquiera, agregando el sketch correspondiente en la carpeta `sketches`.
2. Realice la presentación en markdown o en cualquier otro formato, de acuerdo a la [plantilla adjuntada](https://github.com/VisualComputing/Transformations_ws/blob/gh-pages/source.md) (disponible en la rama `gh-pages`). Si va a hacerlo en markdown, siga las indicaciones de la siguiente sección (*markdown slides*); si lo va a hacer en otro formato, suba la presentación correspondiente a la raíz del repo.

Fecha límite Domingo 16/4/17, a las 24h. Las presentaciones se realizarán en las clases del 17 al 20 de Abril.

## Markdown slides

### Installation

 ```sh
 $ git clone <your_repo>
 $ cd <your_repo>
 $ git checkout gh-pages
 ```

## Folder Structure

    |-- css/
    |-- js/
    |-- plugin/
    |-- lib/
    |-- fig/
    |-- sketches/
    |-- index.html
    |-- source.md
    
Refer to the [reveal folder structure](https://github.com/hakimel/reveal.js#folder-structure) for more details, and to the *Setup* below.

## Setup

External markdown and speaker notes, require that presentations run from a local web server. The following instructions will set up such a server as well as all of the development tasks needed to make edits to the slides source code.

1. Install [Node.js](http://nodejs.org/)

2. Install [Grunt](http://gruntjs.com/getting-started#installing-the-cli)

3. Install dependencies (you must be already on the presentation folder, otherwise ```$ cd <your_repo>```)

 ```sh
 $ npm install
 ```

4. Edit the presentation contents using [markdown](http://daringfireball.net/projects/markdown/) in the `source.md`, adding figures to the `fig/` folder and [p5.js skectches](http://p5js.org/) to the `skectches/` folder (detailed instructions below) as needed.

5. Serve the presentation and monitor source files for changes

 ```sh
 $ grunt serve
 ```

6. Open <http://localhost:8000> to view your presentation

 You can change the port by using `grunt serve --port 8001`.

## [p5.js](http://p5js.org/) sketches

1. Create your js sketch in the ```sketches``` folder, e.g.,


 ```sh
 $ touch sketches/mysketch.js
 ```
 
2. Define a canvas _id_ (e.g., ```mysketch_id```) within your _mysketch.js_ `setup` function:

  * Use [p5.js 'global mode'](https://github.com/lmccart/itp-creative-js/wiki/Spring-2014:-Week-5#global-and-instance-mode) when including just a single sketch into the presentation.

    ```javascript
    function setup() {
        var myCanvas = createCanvas(400, 400);
        myCanvas.parent('mysketch_id');
    }
    ```

  * Use ['instance mode'](https://github.com/lmccart/itp-creative-js/wiki/Spring-2014:-Week-5#global-and-instance-mode) if you need to inlcude more than one:

    ```javascript
    var sketch1 = function( p ) {
        p.setup = function() {
            p.createCanvas(400, 400);
        };
    };
    var myp5_1 = new p5(sketch1, 'mysketch_id');
    ```

3. Include your sketch as a script in the ```index.html```, e.g., ```<script src="sketches/mysketch.js"></script>```

4. Locate your sketch in the ```source.md``` at the place you want it to be, using the _id_: defined in step *2*, e.g., ```<div id='mysketch_id'></div>```
