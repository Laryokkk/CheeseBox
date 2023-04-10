<script>
    import Header from "$lib/components/header/Header.svelte";
    import { fetchPost } from "$lib/utils/util-fetch.js";

    export let data;

    $: listFoto = [];
    $: caseificioData = {};

    const fetchInput = { code: data.code };
    const urlBase = "http://localhost:8888";

    fetchPost(`${urlBase}/select_assets_by_caseificio_code.php`, fetchInput).then(async (fetchResponce) => {
        const { status, data } = fetchResponce;

        if (status >= 400) return;

        data.forEach((asset) => {
            listFoto.push({ src: asset.asset_src });
        });

        listFoto = [...listFoto];
    });

    fetchPost(`${urlBase}/select_caseificio_by_code.php`, fetchInput).then(async (fetchResponce) => {
        const { status, data } = fetchResponce;

        if (status >= 400) return;

        caseificioData = data;
    });
</script>

<Header />
<section class="container">
    <div class="container">
        <h3 class="text text-accent title">
            {caseificioData.name_caseificio}
        </h3>
        <h5 class="text">
            Codice: <span class="text-accent">{caseificioData.code_caseificio}</span>
        </h5>
        <h5 class="text">
            Indirizzo: <span class="text-accent">{caseificioData.caseificio_region}, {caseificioData.caseificio_street}</span>
        </h5>
    </div>
    <div class="container">
        <div class="wrapper-photo">
            {#each listFoto as { src }}
                <img {src} alt="caseificio" />
            {/each}
        </div>
    </div>
</section>

<style>
    section.container {
        height: 60vh;

        padding: 2rem 10vw;

        display: flex;
        align-items: center;
        flex-direction: row;
        gap: 10rem;
    }

    div.container {
        display: flex;
        align-items: flex-start;
        flex-direction: column;
        gap: 1rem;
    }

    .title {
        margin-bottom: 1rem;
    }

    div.wrapper-photo {
        display: flex;
        flex-wrap: wrap;
        gap: 3rem;
    }

    img {
        height: 20rem;

        border-radius: 2rem;
    }
</style>
