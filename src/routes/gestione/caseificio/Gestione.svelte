<script>
    import HeaderSection from "../HeaderSection.svelte";
    import Input from "$lib/components/input/Input.svelte";
    import Button from "$lib/components/button/Button.svelte";
    import { onMount } from "svelte";
    import { fetchPost } from "$lib/utils/util-fetch.js";
    import { getCookie } from "$lib/utils/util-cookie.js";

    $: caseificioCode = null;
    $: inputValue = null;
    $: listFoto = [];
    $: isButtonDisabled = true;

    onMount(async () => {
        let fetchInput = { uuid: getCookie("id_user") };
        let url = "http://localhost:8888/select_user_by_uuid.php";

        await fetchPost(url, fetchInput).then(async (fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            const { user_permission } = data;
            caseificioCode = user_permission.split("_")[1];

            let fetchInput = { code: caseificioCode };
            let url = "http://localhost:8888/select_caseificio_by_code.php";

            await fetchPost(url, fetchInput).then((fetchResponce) => {
                const { status, data } = fetchResponce;

                if (status >= 400) return;

                inputValue = data.name_caseificio;
            });
        });

        fetchInput = { code: caseificioCode };
        url = "http://localhost:8888/select_assets_by_caseificio_code.php";

        await fetchPost(url, fetchInput).then(async (fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            data.forEach((asset) => {
                listFoto.push({ src: asset.asset_src });
            });

            listFoto = [...listFoto]
        });
    });

    const parentHandlerInput = (value) => {
        isButtonDisabled = false;
        inputValue = value;
    };

    const handlerClick = async () => {
        const fetchInput = { name: inputValue, code: caseificioCode };
        const url = "http://localhost:8888/update_caseificio_name_by_code.php";

        await fetchPost(url, fetchInput).then((fetchResponce) => {
            const { status } = fetchResponce;

            if (status >= 400) return;

            isButtonDisabled = true;
        });
    };
</script>

<section class="container">
    <HeaderSection content={`Codice casaeficio: <span class="text-accent">${caseificioCode}</span>`} />
    <div class="container">
        <div class="container-input">
            <h5 class="text">Nome caseificio:</h5>
            <Input
                type="text"
                required="true"
                value={inputValue}
                {parentHandlerInput}
            />
        </div>
        <div class="container-input">
            <h5 class="text">Foto:</h5>
            <div class="wrapper-photo">
                {#each listFoto as { src }}
                    <img {src} alt="caseificio" />
                {/each}
            </div>
        </div>
        <Button text="Salva" disabled={isButtonDisabled} {handlerClick} />
    </div>
</section>

<style>
    section.container {
        height: 90%;

        padding: 2rem 4vw;

        display: flex;
        justify-content: flex-start;
        flex-direction: column;
        gap: 6rem;
    }

    div.container {
        display: flex;
        justify-content: space-between;
        flex-direction: column;
        gap: 4rem;
    }

    div.container-input {
        display: flex;
        align-items: flex-start;
        flex-direction: column;
        gap: 0.4rem;
    }

    div.wrapper-photo {
        display: flex;
        flex-wrap: wrap;
        gap: 2rem;
    }

    img {
        height: 20rem;

        border-radius: 2rem;
    }
</style>
