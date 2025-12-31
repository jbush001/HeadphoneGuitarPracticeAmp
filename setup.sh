python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
VENV_NAME=$(basename "$VIRTUAL_ENV")
python -m ipykernel install --user --name "$VENV_NAME" --display-name "$VENV_NAME"

echo "Setup complete. Activate venv with 'source .venv/bin/activate'"