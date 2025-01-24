import os
import random

from ase.io import read, write
from fire import Fire

def sort_atom_distance(traj, target_dir, *atom_indices, n_frames=5, specorder=None):
    os.makedirs(target_dir, exist_ok=True)
    traj = read(traj, ':')
    if type(traj) is not list:
        traj = [traj]
    distance_map = {}
    for atoms in traj:
        distance = round(atoms.get_distances(atom_indices, mic=True))
        if distance not in distance_map:
            distance_map[distance] = []
        distance_map[distance].append(atoms)
    for distance in sorted(distance_map.keys()):
        atoms = distance_map[distance]
        os.makedirs(os.path.join(target_dir, f'{distance}'), exist_ok=True)
        for i, atoms in enumerate(random.sample(atoms, min(n_frames, len(atoms)))):
            write(
                os.path.join(target_dir, f'{distance}', f'{str(i).zfill(3)}.data'), 
                atoms,
                format='lammps-data',
                specorder=specorder
            )

if __name__ == '__main__':
    Fire(sort_atom_distance)
