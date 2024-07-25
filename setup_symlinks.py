import os
import platform

print(r"""
  ____           _____     _____                 _ _       _        
 / __ \         |  __ \   / ____|               | (_)     | |       
| |  | |_      _| |__) | | (___  _   _ _ __ ___ | |_ _ __ | | _____ 
| |  | \ \ /\ / /  _  /   \___ \| | | | '_ ` _ \| | | '_ \| |/ / __|
| |__| |\ V  V /| | \ \   ____) | |_| | | | | | | | | | | |   <\__ \
 \____/  \_/\_/ |_|  \_\ |_____/ \__, |_| |_| |_|_|_|_| |_|_|\_\___/
                                  __/ |                             
                                 |___/                              
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
SYS_SEP = "\\" if IS_WINDOWS else "/"
HOME_DIR = os.path.expanduser("~")
SCRIPTS_DIR = os.path.join(DOTFILES_PATH, "scripts")

if IS_WINDOWS:
    import ctypes.wintypes
    import winreg

# Check if system is supported (TODO: Add support for Unix/Linux)
if not IS_WINDOWS:
    print(f"{bc.FAIL}{bc.BOLD}Error: Unix/Linux is not supported yet.{bc.END}")
    exit(1)


# -- Helper functions ----------------------------------------------------------------
def dot_path(file):
    file = file.replace("/", SYS_SEP)
    return os.path.join(DOTFILES_PATH, file)

def home_path(file):
    file = file.replace("/", SYS_SEP)
    return os.path.join(HOME_DIR, file)

def w_local_appdata_path(file):
    file = file.replace("/", SYS_SEP)
    return os.path.join(os.getenv('LOCALAPPDATA'), file)

def w_documents_path(file):
    file = file.replace("/", SYS_SEP)
    CSIDL_PERSONAL = 5       # My Documents
    SHGFP_TYPE_CURRENT = 0   # Get current, not default value
    buf = ctypes.create_unicode_buffer(ctypes.wintypes.MAX_PATH)
    ctypes.windll.shell32.SHGetFolderPathW(None, CSIDL_PERSONAL, None, SHGFP_TYPE_CURRENT, buf)

    doc_path = buf.value
    return os.path.join(doc_path, file)

def w_set_env_var(var_name, var_value):
    os.system(f"SETX {var_name} {var_value} > NUL", )
    
def w_add_to_path(path):
    # https://stackoverflow.com/questions/63782773/how-to-modify-windows-10-path-variable-directly-from-a-python-script
    with winreg.ConnectRegistry(None, winreg.HKEY_CURRENT_USER) as root:
            with winreg.OpenKey(root, "Environment", 0, winreg.KEY_ALL_ACCESS) as key:
                existing_path_value = winreg.QueryValueEx(key, 'Path')[0]
                split_path = existing_path_value.split(";")
                if path in split_path:
                    return False
                
                new_path_value = existing_path_value + path + ";"
                winreg.SetValueEx(key, "Path", 0, winreg.REG_EXPAND_SZ, new_path_value)

            # Tell other processes to update their environment
            HWND_BROADCAST = 0xFFFF
            WM_SETTINGCHANGE = 0x1A
            SMTO_ABORTIFHUNG = 0x0002
            result = ctypes.c_long()
            SendMessageTimeoutW = ctypes.windll.user32.SendMessageTimeoutW
            SendMessageTimeoutW(HWND_BROADCAST, WM_SETTINGCHANGE, 0, u"Environment", SMTO_ABORTIFHUNG, 5000, ctypes.byref(result),)
    return True

# -- Print system information --------------------------------------------------------
print(f"{bc.WARNING}Dotfile directory: {bc.END}{DOTFILES_PATH}")
print(f"{bc.WARNING}Platform         : {bc.END}{SYSTEM}")
print(f"{bc.WARNING}Home directory   : {bc.END}{HOME_DIR}")
print("")

# -- Symlinks ------------------------------------------------------------------------
print(f"{bc.HEADER}{bc.BOLD}Creating symlinks...{bc.END}")
files = [
    {
        "name": "Wezterm",
        "src": "wezterm/.wezterm.lua",
        "w_des": home_path(".wezterm.lua")
    },
    {
        "name": "Radian",
        "src": "radian/.radian_profile",
        "w_des": home_path(".radian_profile")
    },
    {
        "name": "R Profile",
        "src": "r/.Rprofile",
        "w_des": home_path(".Rprofile")
    },
    {
        "name": "Powershell",
        "src": "psh/dose_profile.ps1",
        "w_des": w_documents_path("PowerShell/Microsoft.PowerShell_profile.ps1")
    },
    {
        "name": "Starship",
        "src": "starship/starship.toml",
        "w_des": home_path(".config/starship.toml")
    },
    {
        "name": "Git Config",
        "src": "git/.gitconfig",
        "w_des": home_path(".gitconfig")
    },
    {
        "name": "LintR",
        "src": "linter/.lintr",
        "w_des": home_path(".lintr")
    },
    {
        "name": "Neovim",
        "src": "nvim/init.lua",
        "w_des": w_local_appdata_path("nvim/init.lua")
    },
    {
        "name": "Micro",
        "src": "micro/settings.json",
        "w_des": home_path(".config/micro/settings.json")
    }
]

for file in files:
    src_path = dot_path(file["src"])
    des_path = file["w_des"]
    des_dir = os.path.dirname(des_path)
    
    try:
        os.makedirs(des_dir, exist_ok = True)    
        if os.path.exists(des_path):
            os.remove(des_path)
        os.symlink(src_path, des_path)
        print(f"  {bc.BOLD}{file['name']}{bc.END} -> {bc.OKGREEN}{des_path}{bc.END}")

    except Exception as e:
        print(f"{bc.FAIL}X {bc.END}{bc.BOLD}{file['name']}{bc.END} | {bc.FAIL}Error: {e}{bc.END}")


# -- Set R_LIBS_USER environment variable ------------------------------------------
print("")
print(f"{bc.HEADER}{bc.BOLD}Setting R_LIBS_USER environment variable...{bc.END}")
try:
    w_set_env_var("R_LIBS_USER", home_path("R/%v"))
    print(f"  {bc.OKGREEN}Success{bc.END}")
except Exception as e:
    print(f"{bc.FAIL}  Failed with Error:{bc.END} {e}")

# -- Set DOTFILES environment variable ------------------------------------------
print("")
print(f"{bc.HEADER}{bc.BOLD}Setting DOTFILES environment variable...{bc.END}")
try:
    w_set_env_var("DOTFILES", DOTFILES_PATH)
    print(f"  {bc.OKGREEN}Success{bc.END}")
except Exception as e:
    print(f"{bc.FAIL}  Failed with Error:{bc.END} {e}")


# -- Set YAZI_FILE_ONE environment variable ------------------------------------------
print("")
print(f"{bc.HEADER}{bc.BOLD}Setting YAZI_FILE_ONE environment variable...{bc.END}")
try:
    file_exe_git = home_path("scoop/apps/git/current/usr/bin/file.exe")
    w_set_env_var("YAZI_FILE_ONE", file_exe_git)
    print(f"  {bc.OKGREEN}Success{bc.END}")
except Exception as e:
    print(f"{bc.FAIL}  Failed with Error:{bc.END} {e}")
    
# -- Adding scripts to PATH -----------------------------------------------------
print("")
print(f"{bc.HEADER}{bc.BOLD}Adding dotfiles scripts folder to PATH...{bc.END}")
try:
    if (w_add_to_path(SCRIPTS_DIR)):
        print(f"  {bc.OKGREEN}Success{bc.END}")
    else:
        print(f"  {bc.OKGREEN}Already in PATH{bc.END}")
except Exception as e:
    print(f"{bc.FAIL}  Failed with Error:{bc.END} {e}")
    