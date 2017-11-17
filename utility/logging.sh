#****************************************************************************
#** Utility
#****************************************************************************

export COLOR_BLACK=0
export COLOR_RED=1
export COLOR_GREEN=2
export COLOR_YELLOW=3
export COLOR_BLUE=4
export COLOR_MAGENTA=5
export COLOR_CYAN=6
export COLOR_WHITE=7

black=`tput setaf ${COLOR_BLACK}`
red=`tput setaf ${COLOR_RED}`
green=`tput setaf ${COLOR_GREEN}`
yellow=`tput setaf ${COLOR_YELLOW}`
blue=`tput setaf ${COLOR_BLUE}`
magenta=`tput setaf ${COLOR_MAGENTA}`
cyan=`tput setaf ${COLOR_CYAN}`
white=`tput setaf ${COLOR_WHITE}`
reset_color=`tput sgr 0`

#****************************************************************************
#** Print header
#****************************************************************************

# Display colorized warning output
function print() {
    echo "$2$1${reset}"
    #print $2 "${fg[yellow]}$1${reset_color}"
}

# Display colorized information output
function print_header() {
    if [ $2 ]
    then
        print "$2****************************************************************************${reset_color}"
        print "$2* $1${reset_color}"
        print "$2****************************************************************************${reset_color}"
    else
        print "${blue}****************************************************************************${reset_color}"
        print "${blue}* $1${reset_color}"
        print "${blue}****************************************************************************${reset_color}"
    fi

}

# Display colorized warning output
function print_warn() {
    print $2 "${yellow}$1${reset_color}"
}

function print_error() {
    print $2 "${red}$1${reset_color}"
}

function print_success() {
    print $2 "${green}$1${reset_color}"
}

function print_info() {
    print $2 "$1"
}

function print_colour() {
    print $3 "${$1}$2${reset_color}"
}

function print_debug() {
    if [ $DEBUG ]
    then
        print $2 "$1"
    fi
}


#****************************************************************************
