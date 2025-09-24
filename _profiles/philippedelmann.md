---
layout: profile
name: Philipp Edelmann
organization: Los Alamos National Laboratory
title: A modern approach to implicit fluid dynamics
topics: Computational Science Applications (i.e., bioscience, cosmology, chemistry,
  environmental science, nanotechnology, climate, etc.); Computer Science (i.e., architectures,
  compilers/languages, networks, workflow/edge, experiment automation, containers,
  neuromorphic computing, programming models, operating systems, sustainable software);
  High-Performance Computing
abstract: Computational fluid dynamics (CFD) is used every day in many fields of science
  from biology to astrophysics. Yet simulating slow flows (compared to the speed of
  sound) is a hard problem both in terms of numerical accuracy and in terms of efficiency,
  in particular when explicit time stepping is used. Recent work from stellar astrophysics
  has shown that it is feasible to run three-dimensional (3D) CFD simulations with
  fully implicit time stepping. This is significantly more complex and involves the
  use of linear and nonlinear iterative solvers. The trends of the past years and
  especially the new supercomputers of the exascale era have shown that support for
  GPUs is essential. At the same time traditional methods of parallelization using
  the Message Passing Interface (MPI) have trouble coping with heterogeneous (from
  different physics modules) workloads on large systems, which is why task-based approaches
  to parallelization have gained popularity. LANL developed a modern C++ framework
  FleCSI to help writing multiphysics codes while providing abstractions for details
  of the task runtime and GPU vendor library. We propose to implement a prototype
  3D CFD code using FleCSI and our own solvers library FleCSolve and test it on LANL's
  new supercomputer Vendado.
---

## Additional Information

Add additional details about Philipp_Edelmann here using markdown.

### Skills & Expertise

- Add relevant skills
- Add areas of expertise
- Add specializations

### Recent Work

Describe recent projects, publications, or achievements.
