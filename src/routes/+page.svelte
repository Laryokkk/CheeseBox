<script>
    import Input from "$lib/components/input/Input.svelte";
    import HousePhoto from "$lib/components/house/HousePhoto.svelte";
    import CheeseHeading from "$lib/assets/dalle_cheese_0.png";
    import CheeseStats from "$lib/assets/dalle_cheese_1.png";

    import { isEmpty } from "$lib/utils/util-validate.js";

    const caseifici = [
        {
            name: "Bella Casa",
            code: "123421",
            photoPath: "./src/lib/assets/caseifici/house_0.png",
            href: "/casaificio/dasf-gasg112-dsfsd",
        },
        {
            name: "Brutta Home",
            code: "123421342",
            photoPath: "./src/lib/assets/caseifici/house_1.png",
            href: "/casaificio/dasf-gasg112-dsfsd",
        },
    ];

    $: houses = caseifici;

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
                <span class="text-accent">12</span> Caseifici
                <br />
                <span class="text-accent">1257</span> Litri di latte
                <br />
                <span class="text-accent">146</span> Forme prodotte
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
        flex-wrap: wrap;
        gap: 2rem 4rem;

        margin-top: 10vh;
    }
</style>
