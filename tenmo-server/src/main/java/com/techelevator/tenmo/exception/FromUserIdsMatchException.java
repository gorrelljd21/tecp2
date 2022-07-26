package com.techelevator.tenmo.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST, reason = "You cannot send money to yourself.")
public class FromUserIdsMatchException extends Exception{
    private static final long serialVersionUID =1L;

    public FromUserIdsMatchException() {
        super("You cannot send money to yourself.");
    }
}

