<script>
    import Header from "$lib/components/header/Header.svelte";
    import Input from "$lib/components/input/Input.svelte";
    import HousePhoto from "$lib/components/house/HousePhoto.svelte";
    import CheeseHeading from "$lib/assets/dalle_cheese_0.png";
    import CheeseStats from "$lib/assets/dalle_cheese_1.png";

    import { isEmpty } from "$lib/utils/util-validate.js";
    import { fetchPost } from "$lib/utils/util-fetch.js";

    const blobl = {
        v1: {
            left: "100px",
            top: "600px",
        },
        b1: {
            left: "600px",
            top: "300px",
        },
        v2: {
            left: "1300px",
            top: "1200px",
        },
        b2: {
            left: "900px",
            top: "1600px",
        },
    };

    let caseifici = [];
    $: houses = caseifici;

    const init = () => {
        const list = [];
        const url = "http://localhost:8888/select_caseifici.php";

        fetchPost(url, {}).then(async (fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            data.forEach(async (elCasa) => {
                const url =
                    "http://localhost:8888/select_assets_by_caseificio_code.php";

                fetchPost(url, { code: elCasa.code_caseificio }).then(
                    (fetchResponce) => {
                        const { status, data } = fetchResponce;

                        if (status >= 400) return;

                        list.push({
                            name: elCasa.name_caseificio,
                            code: elCasa.code_caseificio,
                            photoPath: data[0] ? data[0].asset_src : 'assets/caseificio_.png',
                            href: `/caseificio/${elCasa.code_caseificio}`,
                        });

                        caseifici = list;
                    }
                );
            });
        });
    };

    init();

    const handlerInput = (value) => {
        if (isEmpty(value)) {
            houses = caseifici;

            return;
        }

        houses = caseifici.filter((el) => {
            const values = Object.values(el);
            let isSuspect = false;

            values.forEach((vl) => {
                if (
                    vl.toLocaleLowerCase().includes(value.toLocaleLowerCase())
                ) {
                    isSuspect = true;
                }
            });

            return isSuspect;
        });
    };
</script>

<Header />
<div class="container">
    <section id="heading">
        <div class="text">
            <h1 class="text">
                Piu di <span class="text-accent">240</span> anni di esperienza
            </h1>
            <h4 class="text">
                Situato in una zona pittoresca e verde, il nostro caseificio
                produce formaggi freschi e stagionati utilizzando solo il latte
                delle nostre mucche, che pascolano liberamente nei campi
                circostanti.
            </h4>
        </div>
        <img src={CheeseHeading} alt="cheese" class="img" />
    </section>
    <section id="stats">
        <img src={CheeseStats} alt="cheese" class="img" />
        <div class="text">
            <h1 class="text">Statistica</h1>
            <h2 class="text">
                <span class="text-accent">∞</span> Caseifici
                <br />
                <span class="text-accent">∞</span> Litri di latte
                <br />
                <span class="text-accent">∞</span> Forme prodotte
            </h2>
        </div>
    </section>
    <section id="caseifici">
        <h1 class="text">Caseifici</h1>
        <Input
            placeholder="Cerca il casaificio"
            parentHandlerInput={handlerInput}
            style="width: 40vw; text-align: center;"
        />
        <div class="container-caseifici">
            {#if houses.length > 0}
                {#each houses as { href, photoPath, name }}
                    <HousePhoto {href} {photoPath} text={name} />
                {/each}
            {:else}
                <h4 class="text">
                    Non abbiamo i caseifici a seconda della ricerca ...
                </h4>
            {/if}
        </div>
    </section>
    <div class="blobs">
        <div
            class="blob-v"
            style="left: {blobl.v1.left}; top: {blobl.v1.top};"
        />
        <div
            class="blob-b"
            style="left: {blobl.b1.left}; top: {blobl.b1.top};"
        />
        <div
            class="blob-v"
            style="left: {blobl.v2.left}; top: {blobl.v2.top};"
        />
        <div
            class="blob-b"
            style="left: {blobl.b2.left}; top: {blobl.b2.top};"
        />
    </div>
</div>

<style>
    div.container {
        display: flex;
        flex-direction: column;
        gap: 10vh;
    }

    section {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: row;
        gap: 10rem;
        margin: 6rem 4rem;
    }

    section#caseifici {
        flex-direction: column;
        gap: 3rem;
        margin: 6rem 4rem;
    }

    section div.text {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        flex-direction: column;
        gap: 30vh;
    }

    img.img {
        border-radius: 4rem;
    }

    div.container-caseifici {
        min-height: 60vh;

        display: flex;
        justify-content: center;
        flex-wrap: wrap;
        gap: 2rem 4rem;

        margin-top: 10vh;
    }

    div.blob-v {
        position: absolute;
        width: 339.63px;
        height: 242.45px;

        background: rgba(186, 90, 231, 0.64);
        filter: blur(100px);
        transform: rotate(-6.74deg);
        z-index: -10;

        animation: blobRotation 5000ms linear infinite alternate;
    }

    div.blob-b {
        position: absolute;
        width: 256.44px;
        height: 185.65px;

        background: rgba(249, 228, 196, 0.64);
        filter: blur(100px);
        transform: rotate(-37.25deg);
        z-index: -10;

        animation: blobRotation 5000ms linear infinite alternate;
    }

    @keyframes blobRotation {
        0% {
            transform: scale(1);
        }
        50% {
            transform: scale(1.2);
        }
        100% {
            transform: scale(0.8);
        }
    }
</style>
