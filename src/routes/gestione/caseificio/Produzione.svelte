<script>
    import HeaderSection from "../HeaderSection.svelte";
    import Check from "$lib/components/check/Check.svelte";
    import Input from "$lib/components/input/Input.svelte";
    import Button from "$lib/components/button/Button.svelte";
    import { onMount } from "svelte";
    import { fetchPost } from "$lib/utils/util-fetch.js";
    import { getCookie } from "$lib/utils/util-cookie.js";

    let caseificioCode = null;
    let formMilk;
    $: isButtonDisabled = true;

    onMount(async () => {
        let fetchInput = { uuid: getCookie("id_user") };
        let url = "http://localhost:8888/select_user_by_uuid.php";

        await fetchPost(url, fetchInput).then(async (fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            const { user_permission } = data;
            caseificioCode = user_permission.split("_")[1];
        });
    });

    const handlerClickMilk = async () => {
        const listMilk = formMilk.querySelectorAll("input");

        let fetchInput = {
            code: caseificioCode,
            quantity: listMilk[0].value,
            type: "racolto",
        };
        let url = "http://localhost:8888/insert_milk.php";

        await fetchPost(url, fetchInput).then(async (fetchResponce) => {
            const { status } = fetchResponce;

            if (status >= 400) return;

            isButtonDisabled = true;
        });

        fetchInput = {
            code: caseificioCode,
            quantity: listMilk[1].value,
            type: "lavorato",
        };
        url = "http://localhost:8888/insert_milk.php";

        await fetchPost(url, fetchInput).then(async (fetchResponce) => {
            const { status } = fetchResponce;

            if (status >= 400) return;

            isButtonDisabled = true;
        });
    };

    const parentHandlerInput = (value) => {
        isButtonDisabled = false;
    };
</script>

<section class="container">
    <HeaderSection />
    <div class="container">
        <div class="wrapper">
            <h3 class="text text-accent">Latte</h3>
            <form name="form-latte" bind:this={formMilk}>
                <div class="container-input">
                    <h5 class="text">Racolto:</h5>
                    <Input type="number" required="true" {parentHandlerInput}/>
                </div>
                <div class="container-input">
                    <h5 class="text">Lavorato:</h5>
                    <Input type="number" required="true" {parentHandlerInput}/>
                </div>
                <Button text="Salva" disabled={isButtonDisabled} handlerClick={handlerClickMilk} />
            </form>
        </div>
        <div class="wrapper">
            <h3 class="text text-accent">Forme</h3>
            <form name="form-forme">
                <div class="internal-wrapper">
                    <div class="container-wrapper">
                        <div class="container-input">
                            <h5 class="text">Codice forma:</h5>
                            <Input
                                type="number"
                                value={"1232421"}
                                required="true"
                                readonly={true}
                            />
                        </div>
                        <div class="container-input">
                            <h5 class="text">Stagionatura:</h5>
                            <Input type="select" options={[]} required="true" />
                        </div>
                    </div>
                    <div class="container-wrapper">
                        <div class="container-input">
                            <h5 class="text">Quantita:</h5>
                            <Input type="number" required="true" />
                        </div>
                        <div class="container-input">
                            <h5 class="text">Scelta:</h5>
                            <Input type="select" options={[]} required="true" />
                        </div>
                    </div>
                </div>
                <Button text="Salva" />
            </form>
        </div>
    </div>
    <Check />
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
        flex-direction: row;
        gap: 6rem;
    }

    div.wrapper {
        display: flex;
        flex-direction: column;
        gap: 3rem;
    }

    form,
    div.container-wrapper {
        display: flex;
        gap: 1rem;
        flex-direction: column;
    }

    div.internal-wrapper {
        display: flex;
        flex-direction: row;
        gap: 4rem;
    }

    div.container-input {
        display: flex;
        align-items: flex-start;
        flex-direction: column;
        gap: 0.2rem;
    }
</style>
