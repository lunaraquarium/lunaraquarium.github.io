let dim = 1000;
let numParticles = 75;
let particleParams = {
  dim: dim,
  size: 25,
  v_amp: 2,
  col: "#DB1500"
}
let bkg = "#000000";
let grid;
let particles = [];

function randomIntFromInterval(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}

function setup() {
  createCanvas(dim, dim);
  testSector = Sector(dim, particleParams, 10);
  grid = Grid(dim, particleParams);
  for (let i = 0; i < numParticles; i++){
    let v_amp = particleParams.v_amp;
    particles.push(Particle(particleParams, i, randomIntFromInterval(50, 950), randomIntFromInterval(50, 950), Math.random() * (v_amp) - v_amp, Math.random() * (v_amp) - v_amp));
  }
  let gui = new GUI();
  gui.title("A Solution of Cranberries - KM, 9/18/24")
}

function draw() {
  background(bkg);
  //gridDisp(grid)
  for (let i = 0; i < particles.length; i++) {
    connect(particles[i], particles, grid, dim, 2*particleParams.size)
    particleDisp(particles[i], grid);
    move(particles[i], dim);
  }

  if(mouseIsPressed) {
    for(let i = 0; i < particles.length; i+=4){
      let pos = createVector(particles[i].x, particles[i].y)
      let vel = createVector(particles[i].vx, particles[i].vy)
      let target = createVector(mouseX, mouseY)
      let desired = p5.Vector.sub(target, pos)
      desired.setMag(0.1)
      let steer = p5.Vector.sub(desired, this.velocity)
      vel.add(steer).limit(2)
      particles[i].vx = vel.x
      particles[i].vy = vel.y
      steer.mult(0)
    }
  }
  
}

//Grid and Sector functions:
//A Sector is a portion of the canvas with a defined size and bucket of particles
//A Grid is an array (1D) of Sectors

function Sector(dim, particleParams, id) {
  let sectorDim = 2*particleParams.size;
  let nwx = (id % Math.floor(dim/sectorDim))*sectorDim;
  let nwy = Math.floor(id/Math.floor(dim/sectorDim))*sectorDim;
  let sectorInfo = {
    objectName: "sector",
    id: id,
    nwx: nwx,
    nwy: nwy,
    dim: sectorDim,
    particles: [],
    fillCol: bkg,
    strokeCol: "#FFFFFF"
  };
  return sectorInfo
}

function sectorDisp(sector) {
  rectMode(CORNER);
  stroke(sector.strokeCol);
  strokeWeight(4);
  fill(sector.fillCol);
  rect(sector.nwx, sector.nwy, sector.dim, sector.dim);
}

function Grid(dim, particleParams) {
  let grid = [];
  let sectorDim = 2*particleParams.size;
  let numSectors = Math.floor(dim/sectorDim) * Math.floor(dim/sectorDim);
  for (let i = 0; i < numSectors; i++) {
    let a = Sector(dim, particleParams, i);
    grid.push(a);
  }
  return grid
}

function gridDisp(grid) {
  for (let i = 0; i < grid.length; i++) {
    sectorDisp(grid[i]);
  }
}




function inSector(centerX, centerY, dim, sectorDim) {
  let x = constrain(centerX, 0, dim-1);
  let y = constrain(centerY, 0, dim-1);
  let inc = Math.floor(dim/sectorDim);
  let long = Math.floor(x/sectorDim);
  let lat = Math.floor(y/sectorDim);
  return lat*inc + long;
}

// Particle functions
// A Particle is a moving agent defined by its center and size (globally controlled)

function Particle(particleParams, id, initX, initY, initvx, initvy) {
  let particleInfo = {
    objectName: "particle",
    id: id,
    size: particleParams.size,
    x: initX,
    y: initY,
    sector: -1,
    vx: initvx,
    vy: initvy,
    fillCol: particleParams.col
  }
  particleInfo.sector = inSector(particleInfo.x, particleInfo.y, particleParams.dim, 2 * particleParams.size);
  return particleInfo
}

function neighborhood_vn(particle, dim, sectorDim) {
  let currentSector = particle.sector
  let y_inc = Math.floor(dim/sectorDim)
  let neighborSectors = [];
  neighborSectors.push(currentSector);
  if (currentSector - y_inc >= 0) {
    neighborSectors.push(currentSector - y_inc)
  }
  if (currentSector + y_inc <= ((y_inc * y_inc) - 1)) {
    neighborSectors.push(currentSector + y_inc)
  }
  if (currentSector - 1 >= 0 && Math.floor((currentSector - 1)/y_inc) == Math.floor(currentSector/y_inc)) {
    neighborSectors.push(currentSector - 1)
  }
  if (currentSector + 1 <= ((y_inc * y_inc) - 1) && Math.floor((currentSector + 1)/y_inc) == Math.floor(currentSector/y_inc)) {
    neighborSectors.push(currentSector + 1)
  }
  return neighborSectors
}

function neighborhood_moore(particle, dim, sectorDim, k) {
  let currentSector = particle.sector
  let y_inc = Math.floor(dim/sectorDim)
  let neighborSectors = [];
  for (let j = -k; j < k + 1; j++) {
    let y = j*y_inc
    let long = Math.floor(currentSector/y_inc) + j
    for (let i = -k; i < k + 1; i++) {
      let index = currentSector + y + i
      let sameLong = Math.floor(index/y_inc) == long
      if(index >= 0 && index <= ((y_inc * y_inc) - 1) && sameLong) {
        neighborSectors.push(index)
      }
    }
}
  return neighborSectors
}


function get_neighbors(particle, grid, dim, sectorDim) {
  let neighborhood = neighborhood_moore(particle, dim, sectorDim, 1)
  let neighbors = []
  for (let i = 0; i < neighborhood.length;i++) {
    sec = grid[neighborhood[i]]
    neighbors = neighbors.concat(sec.particles)
  }
  let selfIndex = neighbors.indexOf(particle.id)
  neighbors.splice(selfIndex, 1)
  return neighbors
} 

function connect(particle, particles, grid, dim, sectorDim) {
  let neighbors = get_neighbors(particle, grid, dim, sectorDim)
  strokeWeight(2)
  for(let i = 0; i < neighbors.length; i++) {
    let n = neighbors[i]
    let other = particles[n]
    let d2 = (particle.x - other.x)*(particle.x - other.x) + (particle.y - other.y)*(particle.y - other.y)
    let maxd2 = sectorDim*sectorDim*6.5
    let from = color("#38BCFF")
    let to = color("#000000")
    let col = lerpColor(from, to, d2/maxd2)
    stroke(col)
    line(particle.x, particle.y, other.x, other.y)
  }
}

function particleDisp(particle, grid) {
  let currentSector = inSector(particle.x, particle.y, particleParams.dim, 2*particleParams.size);
  if (!grid[currentSector].particles.includes(particle.id)) {
    grid[currentSector].particles.push(particle.id)
  }
  if (particle.sector >= 0 && particle.sector != currentSector) {
    let index = grid[particle.sector].particles.indexOf(particle.id);
    grid[particle.sector].particles.splice(index, 1);
    particle.sector = currentSector;
  }
  noStroke();
  fill(particle.fillCol);
  circle(particle.x, particle.y, particle.size);
}

function move(particle, dim) {
  if(particle.x - particle.size * 0.5 < 0) {
    //case 1: particle at left margin
    particle.vx *= -1;
  }
  if(particle.x + particle.size * 0.5 > dim) {
    //case 2: particle at right margin
    particle.vx *= -1;
  }
  if(particle.y - particle.size * 0.5 < 0) {
    //case 3: particle at bottom margin
    particle.vy *= -1;
  }
  if(particle.y + particle.size * 0.5 > dim) {
    //case 4: particle at top margin
    particle.vy *= -1;
  }
  particle.x += particle.vx;
  particle.y += particle.vy;
}

