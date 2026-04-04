import requests
import subprocess
import psutil
import json

ANKI_CONNECT_URL = "http://localhost:8765"

ANKI_NOTIFICATION = "<span size='150%'>󰘹</span> !"

while True:

    def anki_running():
        for proc in psutil.process_iter(['name']):
            try:
                if proc.info['name'] and 'anki' in proc.info['name'].lower():
                    return True
            except (psutil.NoSuchProcess, psutil.AccessDenied):
                pass
        return False

    def anki_visible():
        clients = json.loads(subprocess.check_output(["hyprctl", "clients", "-j"]))
        return any(c.get("class") == "anki" for c in clients)

    if anki_visible() or not anki_running():
        break

    def invoke(action, **params):
        try:
            response = requests.post(
                ANKI_CONNECT_URL,
                json={
                    "action": action,
                    "version": 6,
                    "params": params
                },
                timeout=5
            ).json()

            return response["result"]

        except requests.exceptions.RequestException as e:
            raise RuntimeError(f"Connection error: {e}")


    def get_due_count():
        decks = invoke("deckNames")
        stats = invoke("getDeckStats", decks=decks)

        total = 0

        for deck in stats.values():
            total += (
                deck.get("new_count", 0)
                + deck.get("learn_count", 0)
                + deck.get("review_count", 0)
            )

        return total

    def notify(message):
        subprocess.run(
            ["notify-send", "Anki", message],
            check=False
        )


    def main():
        due = get_due_count()

        subprocess.run(["pkill", "-SIGRTMIN+3", "waybar"])
        if due > 0:
            notify(f"You have {due} reviews to do!")
            subprocess.run(["pkill", "-SIGRTMIN+3", "waybar"])
            print(ANKI_NOTIFICATION)
        else:
            print("")


    if __name__ == "__main__":
        main()
    break

