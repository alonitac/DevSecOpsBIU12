# Resource lock with Redis

In this exercise, you will implement a bash program which reserves seats for a digital ticketing solution, using Redis database. 
In simple words: whenever a customer wants to book a seat for an event (e.g. for a theatre show), your bash program will lock the selected seats for a period of time, such that other customers won't be able to book for those seats.


## Preliminaries

- Open [our shared git repo](https://github.com/alonitac/DevSecOpsBIU12.git) in PyCharm (or clone if you didn't do it yet: git -> clone...)
- Make sure you are on Git branch `main`! If the bottom right bar in your PyCharm looks different from  ![New Branch](../.img/git-branches.png), click on it, hover the `main` branch and click **Checkout**.
- On branch `main`, pull the repository ![Pull Button](../.img/pull.png) to get an up-to-date version of the repository.
- From PyCharm button right bar, click the ![New Branch](../.img/git-branches.png) button to display Git branches in the repo. Choose **+ New branch** to create your own git branch by(Git branches will be discussed later).
- In the opened window, give your branch a name according to the following template:

```text
bash_ex5/<alias>
```

While changing `<alias>` to your nickname. e.g. `bash_ex5/alonit`. The branch name must start with `bash_ex5/`.

- [Install Docker on your Ubuntu](https://docs.docker.com/engine/install/ubuntu/) if needed.

## Guidelines

In order to book a seat, first this seat must be locked by a customer. The lock is valid for 600 seconds. Then the customer that locked the seat can book it during the given locking time. Once seat was booked, the lock is being released and this seat cannot be locked anymore. 

1. Run Redis in a Docker container by:
   ```shell
   docker run --rm -p 6378:6379 --name some-redis redis
   ```  
   Your Redis server will be accessible in localhost:6378
2. You are given a solution skeleton in `ex5_optional/seat.sh`. Your goal is to implement the functions `lock`, `release` and `book`. Read the documentation attached at the top of each function.
3. Here is an example of how your program should behave:
   ```
   >> ./seat.sh lock "Oedipus_the_King" "Andreas" 56
   Seat was locked
   
   >> ./seat.sh lock "Oedipus_the_King" "Marios" 56
   This seat is currently locked by other customer, try again later
   
   >> ./seat.sh release "Oedipus_the_King" "Andreas" 56
   The seat was released
   
   >> ./seat.sh book "Oedipus_the_King" "Marios" 56
   Booking failed, please lock the seat before
   
   >> ./seat.sh lock "Oedipus_the_King" "Marios" 56
   The seat was locked
   
   >> ./seat.sh book "Oedipus_the_King" "Marios" 56
   Successfully booked this seat!
   
   >> ./seat.sh lock "Oedipus_the_King" "Andreas" 56
   Locking failed, seat is already booked
   ```

## Submission

_Commit_ and _push_ `ex5_optional/seat.sh` file **only**. Make sure your solution passing the pre-submit tests.


## Good luck
Feel free to ask any questions!

