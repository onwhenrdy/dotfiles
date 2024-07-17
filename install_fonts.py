import os
import platform
from pathlib import Path
import shutil

print(r"""
  ____           _____    ______          _       
 / __ \         |  __ \  |  ____|        | |      
| |  | |_      _| |__) | | |__ ___  _ __ | |_ ___ 
| |  | \ \ /\ / /  _  /  |  __/ _ \| '_ \| __/ __|
| |__| |\ V  V /| | \ \  | | | (_) | | | | |_\__ \
 \____/  \_/\_/ |_|  \_\ |_|  \___/|_| |_|\__|___/     
""")


class bc:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    END = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    
# Get system information    
DOTFILES_PATH = os.path.dirname(os.path.abspath(__file__))
SYSTEM = platform.uname().system
IS_WINDOWS = SYSTEM == "Windows" or "cygwin" in SYSTEM.lower()
HOME_DIR = os.path.expanduser("~")

# Check if system is supported (TODO: Add support for Unix/Linux)
if not IS_WINDOWS:
    print(f"{bc.FAIL}{bc.BOLD}Error: Unix/Linux is not supported yet.{bc.END}")
    exit(1)

FONT_DIR = os.path.join(os.getenv('LOCALAPPDATA'), "Microsoft", "Windows", "Fonts")

print(f"{bc.WARNING}Dotfile directory: {bc.END}{DOTFILES_PATH}")
print(f"{bc.WARNING}Platform         : {bc.END}{SYSTEM}")
print(f"{bc.WARNING}Home directory   : {bc.END}{HOME_DIR}")
print(f"{bc.WARNING}Font directory   : {bc.END}{FONT_DIR}")
print("")

fonts_folder = os.path.join(DOTFILES_PATH, "fonts")
font_files = list(Path(fonts_folder).rglob("*.ttf"))

n_new_fonts = 0
n_existing_fonts = 0

print(f"{bc.HEADER}{bc.BOLD}Installing Fonts...{bc.END}")
try:
    for font_file in font_files:
        existing_font = list(Path(FONT_DIR).glob(font_file.name))
        if not existing_font:
            shutil.copy(font_file, FONT_DIR)
            n_new_fonts += 1
        else:
            n_existing_fonts += 1

    print(f"{bc.OKGREEN}  Fonts installed: {n_new_fonts}{bc.END}")
    print(f"{bc.OKGREEN}  Fonts already installed: {n_existing_fonts}{bc.END}")

except Exception as e:
    print(f"{bc.FAIL}{bc.BOLD}Error: {e}{bc.END}")
