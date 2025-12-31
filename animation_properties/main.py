import numpy as np
import matplotlib.pyplot as plt
from scipy.special import genlaguerre

def wigner_fock_analytic(x, p, n):
    xi = 2 * (x**2 + p**2)
    prefactor = ((-1)**n) / np.pi
    envelope = np.exp(-(x**2 + p**2))
    laguerre = genlaguerre(n, 0)(xi)
    return prefactor * envelope * laguerre

def main():
    x = np.linspace(-6, 6, 200)
    p = np.linspace(-6, 6, 200)
    X, P = np.meshgrid(x, p)

    n_low = [1, 2, 4, 6, 8]
    n_high = [10, 20, 30, 40, 50]

    plt.figure(figsize=(6, 5))
    W0 = wigner_fock_analytic(X, P, 0)
    plt.contourf(X, P, W0, levels=100, cmap='seismic')
    plt.colorbar(label='W(x,p)')
    plt.title('Ground State (n=0)')
    plt.xlabel('X')
    plt.ylabel('P')
    plt.savefig('wigner_n0.png')
    plt.close()

    fig2, ax2 = plt.subplots(1, 5, figsize=(25, 4))
    for i, n in enumerate(n_low):
        W = wigner_fock_analytic(X, P, n)
        c = ax2[i].contourf(X, P, W, levels=100, cmap='seismic')
        ax2[i].set_title(f'State n={n}')
        ax2[i].set_xlabel('X')
        ax2[i].set_ylabel('P')
        ax2[i].set_xticks([])
        ax2[i].set_yticks([])
    fig2.colorbar(c, ax=ax2, orientation='vertical', fraction=0.02, pad=0.04)
    plt.savefig('wigner_low_n.png')
    plt.close()

    fig3, ax3 = plt.subplots(1, 5, figsize=(25, 4))
    for i, n in enumerate(n_high):
        W = wigner_fock_analytic(X, P, n)
        c = ax3[i].contourf(X, P, W, levels=100, cmap='seismic')
        ax3[i].set_title(f'State n={n}')
        ax3[i].set_xlabel('X')
        ax3[i].set_ylabel('P')
        ax3[i].set_xticks([])
        ax3[i].set_yticks([])
    fig3.colorbar(c, ax=ax3, orientation='vertical', fraction=0.02, pad=0.04)
    plt.savefig('wigner_high_n.png')
    plt.close()

if __name__ == "__main__":
    main()
