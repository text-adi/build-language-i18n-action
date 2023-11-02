from build import Tools
import os

TITLE = """
     _                                 ____            _   _       _
    | |       __ _   _ __     __ _    | __ )   _   _  (_) | |   __| |   ___   _ __
    | |      / _' | | '_ \   / _' |   |  _ \  | | | | | | | |  / _' |  / _ \ | '__|
    | |___  | (_| | | | | | | (_| |   | |_) | | |_| | | | | | | (_| | |  __/ | |
    |_____|  \__,_| |_| |_|  \__, |   |____/   \__,_| |_| |_|  \__,_|  \___| |_|
                           |___/ 
                           
    """

COUNT_SYMBOLS_LINE = 29


def title_msg():
    return TITLE


def line_msg():
    return COUNT_SYMBOLS_LINE * '-'


def main():
    print(title_msg())

    print(line_msg())
    print("Build language files...")
    print(line_msg())

    source_dir = os.environ.get('DIR', os.getcwd())
    print(f'Found files in directory "{source_dir}"...')

    print("Start build...")
    for path_to_file, file in Tools.get_all_file_in_dir(os.path.join(source_dir), 'po'):
        print(f"Compile {path_to_file}/{file} > {path_to_file}/{'.'.join(file.split('.')[:-1])}.mo")
        Tools.build_po_to_mo(os.path.join(path_to_file, file))

    print("Finish.")


if __name__ == '__main__':
    main()
